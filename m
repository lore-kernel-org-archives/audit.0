Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9569C37C925
	for <audit@vger.kernel.org>; Mon,  9 Mar 2026 12:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773059064; cv=none; b=kMVtz0QNNI2nr1DFMYOXBX89pM8mOaZyLi4X0WydUWh1VWAyoszA45VdRlX0L7LdEDe/SPOdJwEAgQCknpozgt362YH0yTq+M6bNOBiKbTJhrNu7a6f0YoEtpRUSSWWXe3/9cVyq5IZRc8WqSQxMys5ZO17VGlKvFI8uIVIIxgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773059064; c=relaxed/simple;
	bh=xaU2ZR0QRE0Q20ugVEkpS/rNfaN2J5+F2Kh5qqbbbyk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QTbJvMal4S5d/k3zTGbqiBS7Wz5mzzagHbcRcAvCWqz4T4C2j1603xZljwRu+oX7A/P0h3XxVt8fdvXhOxiESi4brrs6I3dW0BwdP+lJ9tRDO8usDwhVrIFBzP30nNs8P+xwmMeooZ97q0D5Wd+GoxX38Y68ln8mMY3SrCZVfhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Wc8j2+GF; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Wc8j2+GF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773059062;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BaIsZXqeRSDVnhpdlH8q3jbZsWf+OjguV00FWgyiOh8=;
	b=Wc8j2+GFtDE2pGXuRMls90b5cICtGwaCMaSDi8OiChmMV/uPpiAkVn8/Ek+FjXsYIKC3bW
	BMiWJeTnAaDmy42PR7POuso/iSyPAkO7aSL0JVa3RIunz3xXXrz895gvltCccbajHiAfRN
	sWkYF298oanfcA4ULoZXPEkb/rz3b80=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-124-xXAriSmvP9yG4-fjYfJ-Tg-1; Mon, 09 Mar 2026 08:24:21 -0400
X-MC-Unique: xXAriSmvP9yG4-fjYfJ-Tg-1
X-Mimecast-MFC-AGG-ID: xXAriSmvP9yG4-fjYfJ-Tg_1773059060
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-b96edb0feeaso132388566b.1
        for <audit@vger.kernel.org>; Mon, 09 Mar 2026 05:24:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773059060; x=1773663860;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BaIsZXqeRSDVnhpdlH8q3jbZsWf+OjguV00FWgyiOh8=;
        b=WqQkowh5j4ftETfIXGsmxHMA2nfaqsvpENGzWishyeEa9gYudvTGOnGWh45TdnCGMT
         3MOcx0yHG7WDGZzN3zDZbmHstb/zNynR65jAZXcK9MqKuWm5N9NqnMMAwC2KmGJXTKuX
         Z42qkT2bQfE9cYvM6VOzhWgINt2+H4CSSKYUxo+ji9au1ytxGhJot/mS/7XaV8RYB/y2
         t7HO7G6l0IZen3x7XN4IpboZ33o0F6pGHjarRAQxPGw4RzModxIl2PqI50f/3OSdenVC
         EKkeBzRxomb8BMMuGAfN0ATIwAyM0pYgbQypgtVXwBJCoXCbdgRZRT8liPvBjEy6FNj7
         4soA==
X-Gm-Message-State: AOJu0Yz3feQaOwojPM1aGP4KeTfiGtpgqPvkCDppPJCKYLxTVI5RPWPv
	olDQYLR1iox712AkWeFJbvqILG48EO1NhyjrjOFMitHrYp6X90/UTXZQ7tp3uuSw4w2EJzYG9Nm
	jYOUXKQRcOzFQXmP9VRh70IkV8rXuItiKCVgXzVMGMbj6r+pzi3kX20hSuI7tTYX22HyZ7Kr/HQ
	RnVoh8UMMqt0w8D5mCIfxaBKsGMXraItKhS3PQcUanPw==
X-Gm-Gg: ATEYQzw88Jc5OlAJzowvXu8qtp52nmdgFdCkzeTqbywny0px16vFt/lBOHeeq3qXuxa
	UXwnyKsTACK9YhjbF8aVcBxcjXHjnTrjmWWFYaQI5s5wojy+9RN4ZBQ6oubPUsSrAwT7pd/dnTo
	3lETZLfae7be531kT5iZOTAl0zRPluwJxePKcIzN7DYT6F5fn/0DSEmfiRsiz7M402jBoEN/qxr
	rhBaVTSITujIKBmS2shGIu39b5ZzDG8Dc0vMakT5kUUM40k75PYq4C7OziFd6kq6iDampM1flGT
	OWlGyDKzKeV+CbwJvnpQjOw=
X-Received: by 2002:a17:907:e0d8:b0:b96:df8c:42dc with SMTP id a640c23a62f3a-b96df8c48ccmr235121566b.41.1773059059799;
        Mon, 09 Mar 2026 05:24:19 -0700 (PDT)
X-Received: by 2002:a17:907:e0d8:b0:b96:df8c:42dc with SMTP id
 a640c23a62f3a-b96df8c48ccmr235119566b.41.1773059059223; Mon, 09 Mar 2026
 05:24:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260303124229.700524-1-rrobaina@redhat.com> <CAHC9VhTHLfM_-ibaz-DK3VhaLHkgvM7Jo49OQ6up_dqWERUH7g@mail.gmail.com>
In-Reply-To: <CAHC9VhTHLfM_-ibaz-DK3VhaLHkgvM7Jo49OQ6up_dqWERUH7g@mail.gmail.com>
From: Ricardo Robaina <rrobaina@redhat.com>
Date: Mon, 9 Mar 2026 09:24:08 -0300
X-Gm-Features: AaiRm51EYZic8Fv2afHogXN6b8ShwtVwj09CXrYnnsPH2HdkPLmPrdUaHfyxM9A
Message-ID: <CAABTaaB+igV+ux1QidFZHsizeyAw9X5E1APQjkq6UTV=w=JLmA@mail.gmail.com>
Subject: Re: [PATCH] audit: handle unknown status requests in audit_receive_msg
To: Paul Moore <paul@paul-moore.com>
Cc: audit@vger.kernel.org, linux-kernel@vger.kernel.org, eparis@redhat.com, 
	sgrubb@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: QO0PH5lTGuPYaMKu0fILmX9FpWBL5JRXHlUFcN3TTZM_1773059060
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 6, 2026 at 12:22=E2=80=AFAM Paul Moore <paul@paul-moore.com> wr=
ote:
>
> On Tue, Mar 3, 2026 at 7:42=E2=80=AFAM Ricardo Robaina <rrobaina@redhat.c=
om> wrote:
> >
> > Currently, audit_receive_msg() ignores unknown status bits in AUDIT_SET
> > requests, incorrectly returning success to newer user space tools
> > querying unsupported features. This breaks forward compatibility.
> >
> > Fix this by defining AUDIT_STATUS_ALL in the UAPI header and returning
> > -EINVAL if any unrecognized bits are set (s.mask & ~AUDIT_STATUS_ALL).
> > This ensures invalid requests are safely rejected, allowing user space
> > to reliably test for and gracefully handle feature detection on older
> > kernels.
> >
> > Suggested-by: Steve Grubb <sgrubb@redhat.com>
> > Signed-off-by: Ricardo Robaina <rrobaina@redhat.com>
> > ---
> >  include/uapi/linux/audit.h | 9 +++++++++
> >  kernel/audit.c             | 2 ++
> >  2 files changed, 11 insertions(+)
> >
> > diff --git a/include/uapi/linux/audit.h b/include/uapi/linux/audit.h
> > index 14a1c1fe013a..1d5122b9274a 100644
> > --- a/include/uapi/linux/audit.h
> > +++ b/include/uapi/linux/audit.h
> > @@ -356,6 +356,15 @@ enum {
> >  #define AUDIT_STATUS_LOST                      0x0040
> >  #define AUDIT_STATUS_BACKLOG_WAIT_TIME_ACTUAL  0x0080
> >
> > +#define AUDIT_STATUS_ALL (AUDIT_STATUS_ENABLED | \
> > +                         AUDIT_STATUS_FAILURE | \
> > +                         AUDIT_STATUS_PID | \
> > +                         AUDIT_STATUS_RATE_LIMIT | \
> > +                         AUDIT_STATUS_BACKLOG_LIMIT | \
> > +                         AUDIT_STATUS_BACKLOG_WAIT_TIME | \
> > +                         AUDIT_STATUS_LOST | \
> > +                         AUDIT_STATUS_BACKLOG_WAIT_TIME_ACTUAL)
>
> Overall I think this is fine and good, but AUDIT_STATUS_ALL doesn't
> need to be in the UAPI so why don't we move it to
> include/linux/audit.h?  You can put it at the very top, right above
> the AUDIT_INO_UNSET macro.
>

Thanks for reviewing this patch, Paul! Sounds like a good idea, I'll
work on the V2.

> >  #define AUDIT_FEATURE_BITMAP_BACKLOG_LIMIT     0x00000001
> >  #define AUDIT_FEATURE_BITMAP_BACKLOG_WAIT_TIME 0x00000002
> >  #define AUDIT_FEATURE_BITMAP_EXECUTABLE_PATH   0x00000004
> > diff --git a/kernel/audit.c b/kernel/audit.c
> > index 5a0216056524..592383dce090 100644
> > --- a/kernel/audit.c
> > +++ b/kernel/audit.c
> > @@ -1295,6 +1295,8 @@ static int audit_receive_msg(struct sk_buff *skb,=
 struct nlmsghdr *nlh,
> >                 memset(&s, 0, sizeof(s));
> >                 /* guard against past and future API changes */
> >                 memcpy(&s, data, min_t(size_t, sizeof(s), data_len));
> > +               if (s.mask & ~AUDIT_STATUS_ALL)
> > +                       return -EINVAL;
> >                 if (s.mask & AUDIT_STATUS_ENABLED) {
> >                         err =3D audit_set_enabled(s.enabled);
> >                         if (err < 0)
> > --
> > 2.53.0
>
> --
> paul-moore.com
>

