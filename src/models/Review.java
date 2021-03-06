package models;

import java.sql.Timestamp;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.Lob;
import javax.persistence.ManyToOne;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.Table;

import lombok.Getter;
import lombok.Setter;

@Table(name = "reviews")
@NamedQueries({
        // アイデアの全レビューを取得
        @NamedQuery(name = "getReviews", query = "SELECT r FROM Review r WHERE r.idea = :idea ORDER BY r.updatedAt DESC"),
        // カウントを取得
        @NamedQuery(name = "getReviewsCnt", query = "SELECT COUNT(r) FROM Review r WHERE r.idea = :idea")
})

@Getter
@Setter
@Entity
public class Review {
    @Id
    @Column(name = "id")
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @ManyToOne
    @JoinColumn(name = "idea", nullable = false)
    private Idea idea;

    @ManyToOne
    @JoinColumn(name = "member", nullable = false)
    private Member member;

    /*
     * 0 : 下書き
     * 1 : マネージャーのアドバイス有（再ポストの必要）
     * 2 : マネージャーのレビュー待ち
     * 3 : ディレクターのアドバイス有（再ポストの必要）
     * 4 : ディレクターのレビュー待ち
     * 6 : 採用
     * */
    @Column(name = "reviewStatus", nullable = false)
    private Integer reviewStatus;

    @Lob // テキストエリアの指定（改行もデータベースに保存）
    @Column(name = "advice", nullable = true)
    private String advice;

    @Column(name = "createdAt", nullable = false)
    private Timestamp createdAt;

    @Column(name = "updatedAt", nullable = false)
    private Timestamp updatedAt;
}