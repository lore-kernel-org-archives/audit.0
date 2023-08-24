Return-Path: <audit-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8146EC27C40
	for <audit@archiver.kernel.org>; Thu, 24 Aug 2023 14:25:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241588AbjHXOY7 (ORCPT <rfc822;audit@archiver.kernel.org>);
        Thu, 24 Aug 2023 10:24:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241650AbjHXOYt (ORCPT <rfc822;audit@vger.kernel.org>);
        Thu, 24 Aug 2023 10:24:49 -0400
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B04071987
        for <audit@vger.kernel.org>; Thu, 24 Aug 2023 07:24:47 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id 3f1490d57ef6-d77c5414433so1682370276.0
        for <audit@vger.kernel.org>; Thu, 24 Aug 2023 07:24:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1692887087; x=1693491887;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TQODFugwFQATTifdJpfcBkrlfhOPxEM2aLP5PLkcWDo=;
        b=dSMR7rQschsACcFzjsiH8JIoJAtM86mClzySeIKmja7Jd/uDM3YdmpSAbcKGULTso7
         18vIn7sblv9Z3luzKTvtj1bbAD2g2LoOfLTseo5N7qn5Hq7s9bYCiYhN87jAgWa3ROug
         roXRVdml59KNXQS5brLV1X7dLMlscDXV/FrRX/WTWb6WFC3NA6+XF7jgoGcmKXRLWouz
         zYmMwIbnX+p36PGLGu8kavlkHt+++NTMDMJSDZGgbCKwcDN3ghFtmZVPE2m1VryiuTI+
         saA//TpcFeEFll97hGMKzfLmrNZFMBBzMTX3klgSCPvXZSxQLe+rP2wqh5Dha8y/VYrh
         y3KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692887087; x=1693491887;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TQODFugwFQATTifdJpfcBkrlfhOPxEM2aLP5PLkcWDo=;
        b=fTyIYgbfLtvryvodki8Slw7TEOMJMtoWERtjmjs1M0/COalBXLa8ieLQt2YZgcQyo3
         XobcEyr44+PAiqvFt7reXer/mSXo38q3hbDBXVotKh7XiPUrq7InEEMVDih8EJVSjNgu
         YRQD+lQiAfCmvTLexAhV9icVlynpIHmAsXSLfirrpDhTXZecc+aI6m1RFfoLf8R6DDfi
         /mqq5RQMWiwaLnNknFjijWO9mt5/pndbMGtxppcsqLp7BsXd+QFN29h4ixuQOIsW/oT4
         kXQKAySzulTrO5KWHvuDWrTGsu3xCPlnQwzwl4jKkH7btKoxEwq5kVUZZWDcDOwaPO4O
         9BIQ==
X-Gm-Message-State: AOJu0YxIv+z6g6jcegkQslia5LckC8YAiRQQ7fcN3SZDnrnNKyyXEQpY
        ZTCuDzk6W600dU9TyD7rF2zjcW1S8hY+xZt6Zo4S
X-Google-Smtp-Source: AGHT+IGO907DnsDPiOagBnLztV7nZjRdb6OeAA8Xp9UXE2XLs2sDNyPZoYlNozrqEhuowMRVVcJnxsBFT386TpPDXAk=
X-Received: by 2002:a81:6cd5:0:b0:54f:ba89:225d with SMTP id
 h204-20020a816cd5000000b0054fba89225dmr14608213ywc.19.1692887086898; Thu, 24
 Aug 2023 07:24:46 -0700 (PDT)
MIME-Version: 1.0
References: <36b65eb1-ccbf-8b81-468f-b8d88c4be5a3@I-love.SAKURA.ne.jp>
 <CAHC9VhTLQjjQ0QMfBDHYCz9LOAuO=rJWSDEUqPsFE+dowFbN=Q@mail.gmail.com>
 <b06dbdd8-d2f6-b190-5635-948c0a966103@I-love.SAKURA.ne.jp>
 <CAHC9VhSz=3utr_CigGvkMEb6_avJUQq1Ak2smB7neSd76mzjFw@mail.gmail.com>
 <6957af54-16a2-4c28-56ff-dafe95f4e276@I-love.SAKURA.ne.jp>
 <CAHC9VhTj-PQ0qPTiphPLXyJx3bWeqgVS_GPCWNgjqFqBgH6Njg@mail.gmail.com>
 <b0b60fdc-4484-2265-7fdf-8367bf218d18@I-love.SAKURA.ne.jp>
 <CAHC9VhRaUxN=oEyKCOrfrGzJeXDGxv2EKbZH3qwAB6AhKcSfog@mail.gmail.com>
 <68a0ef90-b452-2096-3729-b5c208878ff9@I-love.SAKURA.ne.jp>
 <CAHC9VhTPgnzdn1tmEmufcbseN_Q1CyzxTEzfvZW7OCBTeAadmA@mail.gmail.com>
 <d2557f88-0cda-b0bf-5c76-7c18912798c9@I-love.SAKURA.ne.jp>
 <CAHC9VhTZE2BinivPRLJ9S_21YcmXA6tMdDtAm5w3nk0dbZ0j1w@mail.gmail.com> <e9c593d9-6369-2987-ce20-5832dbebd027@I-love.SAKURA.ne.jp>
In-Reply-To: <e9c593d9-6369-2987-ce20-5832dbebd027@I-love.SAKURA.ne.jp>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 24 Aug 2023 10:24:35 -0400
Message-ID: <CAHC9VhSUjG7Ap-aRtNrryXkRP5oaGVthkTDVH5o8dbEo9bBgCw@mail.gmail.com>
Subject: Re: [PATCH] audit: add task history record
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     linux-audit@redhat.com, audit@vger.kernel.org,
        Steve Grubb <sgrubb@redhat.com>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <audit.vger.kernel.org>
X-Mailing-List: audit@vger.kernel.org

On Thu, Aug 24, 2023 at 9:39=E2=80=AFAM Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:
> On 2023/08/24 22:30, Paul Moore wrote:
> > On Thu, Aug 24, 2023 at 9:21=E2=80=AFAM Tetsuo Handa
> > <penguin-kernel@i-love.sakura.ne.jp> wrote:
> >>
> >> On 2023/08/23 23:48, Paul Moore wrote:
> >>> We've already discussed this both from a kernel load perspective (it
> >>> should be able to handle the load, if not that is a separate problem
> >>> to address) as well as the human perspective (if you want auditing,
> >>> you need to be able to handle auditing).
> >>
> >> No. You haven't shown us audit rules that can satisfy requirements sho=
wn below.
> >>
> >>   (1) Catch _all_ process creations (both via fork()/clone() system ca=
lls and
> >>       kthread_create() from the kernel), and duplicate the history upo=
n process
> >>       creation.
> >
> > Create an audit filter rule to record the syscalls you are interested
> > in logging.
>
> I can't interpret what you are talking about. Please show me using comman=
d line.

I'm sorry Tetsuo, but I've already spent far too much time going in
circles with you on this topic.  As you are capable of submitting
kernel patches, you should be capable of reading a manpage and
experimenting yourself:

https://man7.org/linux/man-pages/man8/auditctl.8.html

--=20
paul-moore.com
